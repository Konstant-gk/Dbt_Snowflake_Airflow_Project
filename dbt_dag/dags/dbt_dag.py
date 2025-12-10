from datetime import datetime

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos import SnowflakeUserPasswordProfileMapping


profile_config = ProfileConfig(
    profile_name="data_pipeline",  # Must match the profile name in dbt_project.yml
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn",
        profile_args={
            "account": "nw12771.uk-south.azure",
            "user": "KONSTANTGK",
            "database": "dbt_db",
            "warehouse": "dbt_wh",
            "schema": "dbt_schema",
            "role": "dbt_role"}
        )
)

dbt_snowflake_dag = DbtDag(
    project_config=ProjectConfig("/usr/local/airflow/dags/data_pipeline"),
    operator_args={"install_deps": True},
    profile_config=profile_config,
    # dbt will be installed via requirements.txt, so use system dbt
    execution_config=ExecutionConfig(dbt_executable_path="dbt"),
    schedule="@daily",  # Changed from schedule_interval to schedule (Airflow 2.4+)
    start_date=datetime(2023, 9, 10),
    catchup=False,
    dag_id="dbt_dag"
)