import streamlit as st
import pandas as pd
import plotly.express as px
from agent import AISQLAgent
from db import run_query

SCHEMA_DESCRIPTION = """
Tables:
1. employee(empId, name, dob, doj, designation, contact, deptId, managerId, totalleaves, salary)
2. leaves_data(leaveId, empId, leaveType, startDate, endDate, reason, status)
3. department(deptId, deptName, deptHeadId)
4. salaryhistory(salaryId, empId, current_salary, previous_salary, salary_before_previous, date_of_change, reason)
"""

@st.cache_resource
def load_agent():
    return AISQLAgent(schema=SCHEMA_DESCRIPTION)

st.set_page_config(page_title="AI SQL Assistant", layout="wide")
st.title("Natural Language SQL Agent")

agent = load_agent()
query = st.text_input("Ask a question about your data")

if query:
    try:
        sql = agent.generate_sql(query)
        st.subheader("Generated SQL")
        st.code(sql, language="sql")

        rows, cols = run_query(sql)
        df = pd.DataFrame(rows, columns=cols)

        st.subheader("Tabular Results")
        st.dataframe(df)

        # Show chart if there are at least 2 columns
        if len(cols) >= 2 and not df.empty:
            st.subheader("Chart")

            chart_type = st.selectbox("Choose chart type", ["Bar Chart", "Line Chart", "Pie Chart", "Scatter Plot", "Histogram"], index=0)

            x_col = st.selectbox("X-axis", cols, index=0)
            y_col = st.selectbox("Y-axis", cols, index=1 if len(cols) > 1 else 0)

            if chart_type == "Bar Chart":
                fig = px.bar(df, x=x_col, y=y_col)
                st.plotly_chart(fig, use_container_width=True)

            elif chart_type == "Line Chart":
                fig = px.line(df, x=x_col, y=y_col)
                st.plotly_chart(fig, use_container_width=True)

            elif chart_type == "Pie Chart":
                fig = px.pie(df, names=x_col, values=y_col)
                st.plotly_chart(fig, use_container_width=True)
                s
            elif chart_type == "Scatter Plot":
                fig = px.scatter(df, x=x_col, y=y_col, title="Scatter Plot")
                st.plotly_chart(fig, use_container_width=True)

            elif chart_type == "Histogram":
                fig = px.histogram(df, x=x_col, title="Histogram")
                st.plotly_chart(fig, use_container_width=True)


    except Exception as e:
        st.error(f"Error: {e}")
