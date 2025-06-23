import os
from openai import OpenAI
#from dotenv import load_dotenv
import streamlit as st 

#load_dotenv()

api_key = st.secrets["OPENAI_API_KEY"]
#if not api_key:
    #raise ValueError("OPENAI_API_KEY not found in .env")

client = OpenAI(api_key=api_key)

class AISQLAgent:
    def __init__(self, schema, model="gpt-3.5-turbo", prompt_path="prompt_template.txt"):
        self.schema = schema
        self.model = model
        # Fixed encoding issue here
        with open(prompt_path, 'r', encoding='utf-8') as file:
            self.template = file.read()

    def generate_sql(self, question):
        prompt = self.template.format(schema=self.schema, question=question)
        response = client.chat.completions.create(
            model=self.model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0
        )
        return response.choices[0].message.content.strip()