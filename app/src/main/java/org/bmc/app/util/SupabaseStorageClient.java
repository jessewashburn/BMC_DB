package org.bmc.app.util;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Path;
import java.time.Duration;
import java.util.Objects;
import java.util.Properties;

/**
 * Minimal Supabase Storage client for uploading files to a public bucket.
 * Uses REST API with service role key. Intended for server-side use only.
 */
public class SupabaseStorageClient {

    private final String supabaseUrl; // e.g., https://xyzcompany.supabase.co
    private final String serviceKey;  // service role key (keep secret)
    private final String bucket;      // e.g., photos

    private final HttpClient http;

    public SupabaseStorageClient(String supabaseUrl, String serviceKey, String bucket) {
        this.supabaseUrl = Objects.requireNonNull(supabaseUrl);
        this.serviceKey = Objects.requireNonNull(serviceKey);
        this.bucket = Objects.requireNonNull(bucket);
        this.http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(15)).build();
    }

    /**
     * Upload a file to the bucket at the given object path.
     * Returns the public URL if the bucket is public.
     */
    public String uploadPublic(File file, String objectPath, String contentType) throws IOException, InterruptedException {
        if (file == null || !file.exists() || !file.isFile()) {
            throw new IOException("File not found: " + (file != null ? file.getAbsolutePath() : "null"));
        }
        String url = String.format("%s/storage/v1/object/%s/%s", trimSlash(supabaseUrl), bucket, stripLeadingSlash(objectPath));

        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(60))
                .header("Authorization", "Bearer " + serviceKey)
                .header("Content-Type", contentType != null ? contentType : "application/octet-stream")
                .POST(HttpRequest.BodyPublishers.ofFile(Path.of(file.getAbsolutePath())))
                .build();

        HttpResponse<String> res = http.send(req, HttpResponse.BodyHandlers.ofString());
        if (res.statusCode() >= 200 && res.statusCode() < 300) {
            return publicUrl(objectPath);
        }
        throw new IOException("Supabase upload failed (" + res.statusCode() + "): " + res.body());
    }

    /**
     * Build the public URL for an object in a public bucket.
     */
    public String publicUrl(String objectPath) {
        return String.format("%s/storage/v1/object/public/%s/%s", trimSlash(supabaseUrl), bucket, stripLeadingSlash(objectPath));
    }

    private static String trimSlash(String base) {
        return base.endsWith("/") ? base.substring(0, base.length() - 1) : base;
    }

    private static String stripLeadingSlash(String p) {
        return p.startsWith("/") ? p.substring(1) : p;
    }

    /**
     * Create client from application.properties if values exist.
     * Returns null if any property is missing.
     */
    public static SupabaseStorageClient fromProperties() {
        try {
            Properties props = new Properties();
            var in = SupabaseStorageClient.class.getClassLoader().getResourceAsStream("application.properties");
            if (in == null) return null;
            props.load(in);
            String url = props.getProperty("supabase.url");
            String key = props.getProperty("supabase.service.key");
            String bucket = props.getProperty("supabase.bucket", "photos");
            if (url == null || key == null || bucket == null || url.isBlank() || key.isBlank() || bucket.isBlank()) {
                return null;
            }
            return new SupabaseStorageClient(url, key, bucket);
        } catch (Exception e) {
            return null;
        }
    }
}
