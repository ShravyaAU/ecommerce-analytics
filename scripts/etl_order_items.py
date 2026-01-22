import pandas as pd
from pathlib import Path

RAW_PATH = Path("data/raw/olist_order_items_dataset.csv")
OUT_PATH = Path("data/processed/order_items_clean.csv")

DATE_COLS = ["shipping_limit_date"]

def main():
    # 1) Load
    df = pd.read_csv(RAW_PATH)
    print("Loaded order_items:", df.shape)

    # 2) Standardize column names
    df.columns = [c.strip().lower() for c in df.columns]

    # 3) Convert timestamps
    for col in DATE_COLS:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col], errors="coerce")

    # 4) Basic integrity checks
    required_cols = ["order_id", "order_item_id", "product_id", "seller_id", "price", "freight_value"]
    missing_required = [c for c in required_cols if c not in df.columns]
    if missing_required:
        raise ValueError(f"Missing required columns: {missing_required}")

    before = len(df)
    df = df.dropna(subset=["order_id", "order_item_id", "product_id"])
    after = len(df)
    if before != after:
        print(f"Dropped {before - after} rows with null keys")

    # 5) Ensure numeric types
    df["price"] = pd.to_numeric(df["price"], errors="coerce")
    df["freight_value"] = pd.to_numeric(df["freight_value"], errors="coerce")

    # 6) Duplicate check for grain: (order_id, order_item_id) should be unique
    dupes = df.duplicated(subset=["order_id", "order_item_id"]).sum()
    print("Duplicate (order_id, order_item_id) rows:", dupes)

    # 7) Save processed
    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(OUT_PATH, index=False)
    print("Saved:", OUT_PATH, "rows:", len(df))

if __name__ == "__main__":
    main()
