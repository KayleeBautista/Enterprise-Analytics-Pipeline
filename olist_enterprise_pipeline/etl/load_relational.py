import pandas as pd
import os
from sqlalchemy import text
from etl.config import engine

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_PATH = os.path.join(BASE_DIR, "data")


def load_csv(file_name, table_name):
    file_path = os.path.join(DATA_PATH, file_name)
    
    df = pd.read_csv(file_path)

    df = df.rename(columns={
        "product_name_lenght": "product_name_length",
        "product_description_lenght": "product_description_length"
        })

    if table_name == "order_reviews":
        before = len(df)
        df = df.drop_duplicates(subset=["review_id"])
        after = len(df)
        print(f"Removed {before - after} duplicate review rows")


    df.to_sql(
        table_name,
        engine,
        schema="relational_dw",
        if_exists="append",
        index=False,
        chunksize=1000,
        method="multi"
    )

    print(f"Inserted {len(df)} rows into relational_dw.{table_name}")


def truncate_tables():
    print("Truncating existing relational tables...")

    truncate_sql = """
    TRUNCATE TABLE 
        relational_dw.order_reviews,
        relational_dw.order_payments,
        relational_dw.order_items,
        relational_dw.orders,
        relational_dw.product_category_translation,
        relational_dw.products,
        relational_dw.sellers,
        relational_dw.customers,
        relational_dw.geolocation
    CASCADE;
    """

    with engine.begin() as conn:
        conn.execute(text(truncate_sql))

    print("Truncation complete.")


def main():
    truncate_tables()

    load_csv("olist_customers_dataset.csv", "customers")
    load_csv("olist_sellers_dataset.csv", "sellers")
    load_csv("olist_products_dataset.csv", "products")
    load_csv("product_category_name_translation.csv", "product_category_translation")
    load_csv("olist_orders_dataset.csv", "orders")
    load_csv("olist_order_items_dataset.csv", "order_items")
    load_csv("olist_order_payments_dataset.csv", "order_payments")
    load_csv("olist_order_reviews_dataset.csv", "order_reviews")
    load_csv("olist_geolocation_dataset.csv", "geolocation")

    print("\nAll relational tables loaded successfully.")


if __name__ == "__main__":
    main()