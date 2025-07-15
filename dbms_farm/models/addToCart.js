import express from "express"
import initSqlConnection from "./database.js"

const addToCart = async (productName, price, quantity, farmerId, consumerId, purchaseDate) => {
  try {
    await con.query('INSERT INTO Consumer_Cart (Consumer_ID, Farmer_ID, Product_Name, Quantity_Bought, Price, Purchase_Date) values(?,?,?,?,?,?)', [consumerId, farmerId, productName, quantity, price, purchaseDate])
    await con.query('UPDATE Available_Products SET Quantity = Quantity - ? WHERE Farmer_ID = ?  AND Product_Name = ? AND Quantity >= ?;', [quantity, farmerId, productName, 2])
    const [productId] = await con.query('select Product_ID from Products where Product_Name =?', [productName])

    await con.query('INSERT INTO Sold_Products (Farmer_ID, Product_Name, Product_ID, Quantity_Sold, Price, Puchase_Date) values(?,?,?,?,?,?)', [farmerId, productName, productId[0].Product_ID, quantity, price, purchaseDate])
    console.log('inserted sucessfully')
  } catch (error) {
    console.log('data not inserted ! ', error)

  }

}

export default addToCart