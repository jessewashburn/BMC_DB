-- ===========================================================
-- Baltimore Metal Crafters Database (Postgres / Supabase)
-- Seed Data for DEV
-- ===========================================================

-- No database selection (handled by connection)

-- 1. CUSTOMERS
INSERT INTO customer (name, phone, email, address) VALUES
('Restoration Society of Baltimore', '410-555-0101', 'contact@rsb.org', '123 Historic Ave, Baltimore, MD 21201'),
('City of Baltimore Parks Dept', '410-555-0102', 'parks@baltimore.gov', '100 Holliday St, Baltimore, MD 21202'),
('Maryland Historical Trust', '410-555-0103', 'info@mht.maryland.gov', '100 Community Pl, Crownsville, MD 21032'),
('Private Collector - Johnson', '410-555-0104', 'mjohnson@email.com', '456 Elm Street, Towson, MD 21204'),
('St. Mary''s Church', '410-555-0105', 'office@stmarys.org', '789 Cathedral St, Baltimore, MD 21201'),
('Baltimore Museum of Art', '410-555-0106', 'collections@artbma.org', '10 Art Museum Dr, Baltimore, MD 21218');

-- 2. EMPLOYEES
INSERT INTO employee (name, role, specialization, contact_info) VALUES
('Sarah Mitchell', 'admin', 'Project Management', 'sarah.mitchell@bmc.com'),
('Marcus Rodriguez', 'restorer', 'Historic Ironwork', 'marcus.rodriguez@bmc.com'),
('Jennifer Chen', 'restorer', 'Surface Treatment & Patina', 'jennifer.chen@bmc.com'),
('David Thompson', 'fabricator', 'Welding & Assembly', 'david.thompson@bmc.com'),
('Lisa Anderson', 'fabricator', 'Metalworking & Forming', 'lisa.anderson@bmc.com'),
('Robert Wilson', 'restorer', 'Structural Analysis', 'robert.wilson@bmc.com');

-- 3. MATERIALS
INSERT INTO material (name, category, stock_quantity, reorder_level, unit_cost) VALUES
('Steel Rod 1/2"', 'Raw Materials', 25, 10, 12.50),
('Steel Plate 1/4"', 'Raw Materials', 15, 8, 45.00),
('Cast Iron Paint', 'Finishes', 8, 5, 35.00),
('Rust Converter', 'Chemicals', 12, 6, 28.50),
('Welding Rod E7018', 'Consumables', 100, 20, 2.75),
('Sandpaper 80-grit', 'Consumables', 50, 15, 3.25),
('Primer - Metal', 'Finishes', 6, 3, 42.00),
('Black Oxide Finish', 'Finishes', 4, 2, 65.00),
('Bronze Brazing Rod', 'Consumables', 30, 10, 8.50),
('Wire Brush Steel', 'Tools', 15, 5, 12.00');

-- 4. VENDORS
INSERT INTO vendor (name, contact_info, phone, email) VALUES
('Baltimore Steel Supply', '1001 Industrial Blvd, Baltimore, MD', '410-555-1001', 'orders@baltimoresteel.com'),
('MetalCraft Supplies', '250 Harbor Dr, Annapolis, MD', '410-555-1002', 'sales@metalcraft.com'),
('Industrial Paint Solutions', '500 Commerce St, Baltimore, MD', '410-555-1003', 'info@indpaint.com'),
('Restoration Tools Inc', '75 Artisan Way, Frederick, MD', '301-555-1004', 'support@restotools.com');

-- 5. QUOTES
INSERT INTO quote (customer_id, date_created, total_estimate, approved, notes) VALUES
(1, '2025-10-01', 15000.00, TRUE, 'Historic gate restoration for main entrance'),
(2, '2025-10-05', 8500.00, TRUE, 'Park bench repair and refinishing - 5 units'),
(3, '2025-10-10', 25000.00, FALSE, 'Colonial-era weathervane restoration'),
(4, '2025-10-15', 3200.00, TRUE, 'Antique door hardware restoration'),
(5, '2025-10-18', 12000.00, FALSE, 'Altar rail restoration and refinishing'),
(6, '2025-10-20', 18500.00, FALSE, 'Museum display case metalwork');

-- 6. QUOTE ITEMS
INSERT INTO quoteitem (quote_id, description, est_labor_cost, est_material_cost) VALUES
(1, 'Structural assessment and documentation', 2000.00, 0.00),
(1, 'Rust removal and surface preparation', 4000.00, 500.00),
(1, 'Metalwork repair and welding', 6000.00, 1200.00),
(1, 'Primer and finish application', 1500.00, 800.00),
(2, 'Disassembly and cleaning - 5 benches', 1500.00, 200.00),
(2, 'Metalwork repairs', 3000.00, 800.00),
(2, 'Sandblasting and refinishing', 2500.00, 500.00),
(4, 'Hardware cleaning and assessment', 800.00, 100.00),
(4, 'Restoration of hinges and locks', 1800.00, 300.00),
(4, 'Polishing and protective coating', 700.00, 200.00);

-- 7. JOBS
INSERT INTO job (customer_id, quote_id, description, start_date, due_date, status) VALUES
(1, 1, 'Historic Entrance Gate Restoration', '2025-10-08', '2025-11-15', 'InProgress'),
(2, 2, 'Patterson Park Bench Restoration', '2025-10-12', '2025-11-01', 'InProgress'),
(4, 4, 'Victorian Door Hardware Set', '2025-10-22', '2025-11-08', 'Planned'),
(1, NULL, 'Emergency Railing Repair', '2025-10-20', '2025-10-25', 'InProgress'),
(3, NULL, 'Survey - State House Fixtures', '2025-10-25', '2025-10-30', 'Planned');

-- 8. JOB STAGES
INSERT INTO jobstage (job_id, stage_name, start_date, end_date) VALUES
(1, 'Assessment', '2025-10-08', '2025-10-10'),
(1, 'Disassembly', '2025-10-11', '2025-10-15'),
(1, 'Cleaning', '2025-10-16', '2025-10-22'),
(1, 'Repair', '2025-10-23', NULL),
(1, 'Finishing', NULL, NULL),
(1, 'Reassembly', NULL, NULL),
(2, 'Disassembly', '2025-10-12', '2025-10-14'),
(2, 'Cleaning', '2025-10-15', '2025-10-18'),
(2, 'Repair', '2025-10-19', NULL),
(2, 'Finishing', NULL, NULL),
(4, 'Assessment', NULL, NULL),
(4, 'Cleaning', NULL, NULL),
(4, 'Restoration', NULL, NULL);

-- 9. NOTES
INSERT INTO notes (job_id, note_text, created_at) VALUES
(1, 'Gate shows significant rust damage on lower sections. Will require replacement of bottom rail.', '2025-10-08 09:30:00+00'),
(1, 'Historical research completed. Gate dates to 1890s, original finish was black paint over primer.', '2025-10-09 14:15:00+00'),
(1, 'Customer approved color match sample. Proceeding with agreed finish specifications.', '2025-10-10 11:00:00+00'),
(2, 'All 5 benches have similar wear patterns. Standardizing repair approach.', '2025-10-12 10:45:00+00'),
(2, 'Parks department requested expedited timeline for Halloween event setup.', '2025-10-15 16:20:00+00'),
(4, 'Client provided historical photos for reference. Lock mechanism is rare 1880s design.', '2025-10-21 13:30:00+00');

-- 10. PHOTOS
INSERT INTO photo (job_id, file_path, description) VALUES
(1, 'photos/job1/before_001.jpg', 'Gate - overall condition before restoration'),
(1, 'photos/job1/detail_rust_001.jpg', 'Close-up of rust damage on lower rail'),
(1, 'photos/job1/historical_ref_001.jpg', 'Historical photo from 1920s showing original condition'),
(2, 'photos/job2/bench_assembly_001.jpg', 'Typical bench disassembly'),
(2, 'photos/job2/wear_pattern_001.jpg', 'Standard wear pattern on bench supports'),
(4, 'photos/job4/hardware_set_001.jpg', 'Complete Victorian door hardware set');

-- 11. JOB MATERIALS
INSERT INTO jobmaterial (job_id, material_id, quantity_used) VALUES
(1, 1, 3),
(1, 2, 1),
(1, 3, 2),
(1, 4, 1),
(1, 5, 15),
(2, 4, 2),
(2, 6, 20),
(2, 7, 3),
(2, 3, 3),
(4, 9, 2),
(4, 10, 5);

-- 12. PURCHASE ORDERS
INSERT INTO purchaseorder (vendor_id, order_date, total_cost, status) VALUES
(1, '2025-10-01', 750.00, 'Received'),
(2, '2025-10-15', 420.50, 'Received'),
(3, '2025-10-18', 315.00, 'Pending'),
(4, '2025-10-20', 180.00, 'Pending');

-- 13. PO ITEMS
INSERT INTO poitem (po_id, material_id, quantity, unit_price) VALUES
(1, 1, 20, 12.50),
(1, 2, 10, 45.00),
(2, 5, 100, 2.75),
(2, 6, 50, 3.25),
(3, 3, 5, 35.00),
(3, 7, 4, 42.00),
(4, 10, 15, 12.00);

-- 14. INVOICES
INSERT INTO invoice (job_id, invoice_date, total_amount, paid) VALUES
(2, '2025-10-20', 4250.00, FALSE),
(1, '2025-10-15', 7500.00, TRUE),
(4, '2025-10-22', 1600.00, FALSE);

-- 15. PAYMENTS
INSERT INTO payment (invoice_id, payment_date, amount, method) VALUES
(2, '2025-10-15', 7500.00, 'Check'),
(1, '2025-10-21', 2000.00, 'Card'),
(1, '2025-10-22', 2250.00, 'Card');

-- 16. SHIPMENTS
INSERT INTO shipment (job_id, ship_date, carrier, tracking_number) VALUES
(1, NULL, 'Customer Pickup', NULL);
