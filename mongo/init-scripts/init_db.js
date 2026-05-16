print("Starting MongoDB Schema Initialization...");

db = db.getSiblingDB('mechanic_db');

// 1. Create Collections explicitly (Added parts)
db.createCollection("customers");
db.createCollection("mechanics");
db.createCollection("cars");
db.createCollection("jobs");
db.createCollection("orders");
db.createCollection("parts"); // <--- Explicitly added
db.createCollection("reference_data");

// 2. Insert Reference Data (Fuel Types)
db.reference_data.updateOne(
  { _id: "fuel_types" },
  {
    $set: {
      fuel_types: [
        { code: "D", name: "diesel" },
        { code: "Gas", name: "gasoline" },
        { code: "CNG", name: "compressed natural gas" },
        { code: "LPG", name: "liquefied petroleum gas" },
        { code: "EV", name: "electricity" },
        { code: "H2", name: "hydrogen" },
        { code: "B20", name: "biodiesel" },
        { code: "E85", name: "ethanol" },
        { code: "HEV", name: "full hybrid electric" },
        { code: "MHEV", name: "mild hybrid" }
      ]
    }
  },
  { upsert: true }
);

// 3. Insert Customers
var customerResult = db.customers.insertMany([
  { last_name: "Smith", first_name: "John", address: "123 Main St, City", email: "john.smith@email.com", tel: "+121234567890" },
  { last_name: "Doe", first_name: "Jane", address: "456 Oak Ave, Town", email: "jane.doe@email.com", tel: "+441234567890" },
  { last_name: "Johnson", first_name: "Alex", address: "789 Pine Rd, Village", email: "alex.johnson@email.com", tel: "+911234567890" }
]);
var johnSmithId = customerResult.insertedIds[0];

// 4. Insert Mechanics
var mechanicResult = db.mechanics.insertMany([
  {
    last_name: "Smith", first_name: "John", address: "123 Elm Street",
    email: "john.smith@example.com", tel: "1234567890", hire_date: new Date("2020-01-15"),
    salary: { starting: 40000, current: 45000, bonuses: 2000, increase: 5000 }
  },
  {
    last_name: "Johnson", first_name: "Emma", address: "456 Oak Avenue",
    email: "emma.johnson@example.com", tel: "2345678901", hire_date: new Date("2019-06-20"),
    salary: { starting: 42000, current: 48000, bonuses: 2500, increase: 6000 }
  }
]);
var johnMechanicId = mechanicResult.insertedIds[0];

// 5. Insert Cars
var carResult = db.cars.insertMany([
  {
    owner_id: johnSmithId,
    owner_name: "John Smith",
    plate_number: "AB 12 XYZ",
    brand_name: "Toyota",
    model_name: "Corolla",
    engine_code: "1NZ-FE",
    vin: "JTDBU4EE9A1234567",
    fabr_year: 2015,
    fuel_type: "Gas",
    color: "Red",
    oil: "5W-30",
    km: 80000,
    tire_specs: "205/55 R16 91 V"
  }
]);

// NEW: 5.5 Insert Parts Stock Registry (So Feladat 4 actually works!)
db.parts.insertMany([
  { name: "Engine Oil", description: "High-quality engine oil 5W-30", quantity: 15 },
  { name: "Oil Filter", description: "Oil filter for engine oil change", quantity: 8 },
  { name: "Tires", description: "All-season performance tires", quantity: 0 } // Out of stock example
]);

// 6. Insert Jobs
db.jobs.insertMany([
  {
    scheduled_date: new Date("2024-05-01"),
    vehicle: {
      plate: "AB 12 XYZ",
      brand: "Toyota",
      model: "Corolla"
    },
    mechanic: {
      name: "John Smith",
      id_ref: johnMechanicId
    },
    operation: {
      description: "Routine vehicle maintenance including oil change and tire check",
      time_required: 120,
      cost: 500
    },
    field_job: {
      address: "123 Main St, Springfield",
      distance: 150,
      travel_cost: 937.50
    },
    parts_used: [
      { name: "Engine Oil", desc: "High-quality engine oil for vehicles, 5W-30" },
      { name: "Oil Filter", desc: "Oil filter for engine oil change" }
    ],
    status: "completed"
  }
]);

// 7. Insert Orders
db.orders.insertMany([
  {
    order_date: new Date("2024-01-20"),
    distributor: "ABC Distributors",
    delivery_method: "Air Freight",
    delivery_date: new Date("2024-01-25"),
    items: [
      { part_name: "Engine Oil", qty: 1 },
      { part_name: "Oil Filter", qty: 1 },
      { part_name: "Tires", qty: 2 }
    ]
  }
]);

print("Schema and Sample Data Initialization Complete!");
