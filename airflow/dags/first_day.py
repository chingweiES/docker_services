from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

# 定義各個任務的動作
def extract():
    print("extract from data source")

def transform():
    print("transform data")
    
def load():
    print("load data to the target")

# 定義DAG
# 使用 with 語法來定義 DAG 範圍
# 各參數為: DAG ID、預設參數、描述、排程、開始日期、是否補齊過去任務
with DAG(
    "first_dag",
    default_args={
        "retries": 1,
        "retry_delay": timedelta(minutes=5),
    },
    description="my first DAG",
    schedule=timedelta(days=1),
    start_date=datetime(2026, 1, 31),
    catchup=False,
) as dag:
    
    # 定義 Task
    extract_task = PythonOperator(
    task_id="extract", python_callable=extract, dag=dag,
    )

    transform_task = PythonOperator(
    task_id="transform", python_callable=transform, dag=dag,
    )
    
    load_task = PythonOperator(
    task_id="load", python_callable=load, dag=dag,
    )
    
    # 定義 Task 關聯關係
    extract_task >> transform_task >> load_task
