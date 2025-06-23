import os
from dotenv import load_dotenv
import psycopg2
import streamlit as st

load_dotenv()

@st.cache_resource
def get_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT")
    )

def run_query(sql):
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)
            rows = cursor.fetchall()
            colnames = [desc[0] for desc in cursor.description]
        return rows, colnames
    except Exception as e:
        conn.rollback()  # this resets the broken transaction state
        st.error(f"Query failed: {e}")
        return [], []    # Return empty result to avoid crashing Streamlit
