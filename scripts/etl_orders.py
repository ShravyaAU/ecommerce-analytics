import pandas as pd
from pathlib import Path

RAW_PATH = Path("data/raw/olist_orders_dataset.csv")
OUT_PATH = Path("data/processed/orders_clean.csv")

DATE_COLS = [
    "order_purchase_timestamp",
    "order_approved_at",
    "order_delivered_carrier_date",
    "order_delivered_customer_date",
    "order_estimated_delivery_date",
]

def main():
    # 1) Load
    orders = pd.read_csv(RAW_PATH)
    print("Loaded orders:", orders.shape)

    # 2) Standardize column names
    orders.columns = [c.strip().lower() for c in orders.columns]

    # 3) Convert timestamps (nulls are allowed)
    for col in DATE_COLS:
        if col in orders.columns:
            orders[col] = pd.to_datetime(orders[col], errors="coerce")

    # 4) Basic integrity checks
    # order_id should never be null
    before = len(orders)
    orders = orders.dropna(subset=["order_id"])
    after = len(orders)
    if before != after:
        print(f"Dropped {before - after} rows with null order_id")

    # order_id should be unique in orders table
    dupes = orders["order_id"].duplicated().sum()
    print("Duplicate order_id rows:", dupes)

    # 5) Save processed
    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    orders.to_csv(OUT_PATH, index=False)
    print("Saved:", OUT_PATH, "rows:", len(orders))

if __name__ == "__main__":
    main()
