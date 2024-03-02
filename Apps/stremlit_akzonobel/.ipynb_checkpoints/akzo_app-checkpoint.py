import streamlit as st
import pandas as pd
from pathlib import Path

# Set the theme to 'light' and enable wide mode
st.set_page_config(layout="wide")

file_path = Path('/home/hama/Downloads/AKZONOBEL 2023-TEMMUZ SATIŞ FİYAT LİSTESİ_csv.csv')

# Function to load CSV file
def load_data(csv_file: Path) -> pd.DataFrame:
    """
    Load data from a CSV file.
    
    Parameters:
        csv_file (Path): Path to the CSV file.
    
    Returns:
        pd.DataFrame: DataFrame containing the loaded data.
    """
    try:
        data = pd.read_csv(csv_file)
        return data
    except FileNotFoundError:
        st.error("File not found. Please check the file path.")
        return pd.DataFrame()

# Function to clean DataFrame
def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    """
    Clean the DataFrame by selecting columns, renaming them, and converting data types.
    
    Parameters:
        df (pd.DataFrame): Input DataFrame.
    
    Returns:
        pd.DataFrame: Cleaned DataFrame.
    """
    # Select desired columns
    df = df[['Marka', 'Grup', 'Malzeme', 'Malzeme.1', 'Brm Kg', '2023\nFİYAT USD']]
    
    # Rename columns
    df = df.rename(columns={
        'Marka': 'Brand',
        'Grup': 'Product_Group',
        'Malzeme': 'Product_Code',
        'Malzeme.1': 'Product_Name',
        'Brm Kg': 'Weight_Kg',
        '2023\nFİYAT USD': 'Price_USD'
    })
    
    # Remove '$' sign from price column and convert to float
    df['Price_USD'] = df['Price_USD'].replace({'\$': '', ',': ''}, regex=True).astype(float)
    
    return df


# # Function to export DataFrame to Excel
# def export_to_excel(df: pd.DataFrame, file_name: str):
#     """
#     Export DataFrame to an Excel file.
    
#     Parameters:
#         df (pd.DataFrame): DataFrame to be exported.
#         file_name (str): Name of the Excel file.
#     """
#     with pd.ExcelWriter(file_name, engine='xlsxwriter') as writer:
#         df.to_excel(writer, index=False, sheet_name='Sheet1')
#         workbook = writer.book
#         worksheet = writer.sheets['Sheet1']
        
#         # Add total price at the bottom of the DataFrame
#         last_row = len(df) + 1
#         total_price_formula = f"SUM(E2:E{last_row})"
#         worksheet.write_formula(f'E{last_row + 1}', total_price_formula)

def main():
    # Load the CSV file
    df = load_data(file_path)
    if df.empty:
        return
    
    # Clean the DataFrame
    df = clean_data(df)

    # Display the table
    st.write("## Inventory Table")
    st.dataframe(df)
    

    # Allow for selection of items and input of quantity
    selected_rows = st.multiselect("Select Rows", df['Product_Name'])

    # Display selected rows with quantities
    if selected_rows:
        quantities = {}  # Dictionary to store quantities for each selected item
        for item in selected_rows:
            quantity = st.number_input(f"Quantity for {item}", min_value=0, step=1, key=item)
            quantities[item] = quantity

        selected_df = df[df['Product_Name'].isin(selected_rows)]  # Filter DataFrame based on selected items
        selected_df['Quantity'] = selected_df['Product_Name'].map(quantities)  # Add quantity column to selected rows
        selected_df['Cumulative_Price_$'] = selected_df['Quantity'] * selected_df['Price_USD']  # Calculate total price
        
        total_price = selected_df['Cumulative_Price_$'].sum()
        # Append total price row to the DataFrame
        total_row = pd.DataFrame({'Product_Name': ['Total'], 'Quantity': [''], 'Brand': [''], 'Product_Group': [''], 'Product_Code': [''], 'Weight_Kg': [''], 'Price_USD': [''], 'Cumulative_Price_$': [total_price]})
        # selected_df = selected_df.append(total_row, ignore_index=True)
        selected_df = pd.concat([selected_df,total_row], ignore_index = True)
        
        if not selected_df.empty:
            st.write("### Selected Rows with Quantities")
            st.dataframe(selected_df)
            
            # calcualte the totla $ of the order
            # total_price = selected_df['Cumulative_Price_$'].sum()
            st.sidebar.write('total_price')
            st.sidebar.write(f"${total_price:.2f}")

            
            
            



        
        else:
            st.write("No rows selected")

if __name__ == "__main__":
    main()
