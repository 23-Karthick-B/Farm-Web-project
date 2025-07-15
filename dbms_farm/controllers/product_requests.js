
import express from "express";
import { findProductsByName, findProductsOfType, productsByFarmerId, getUserId, productTypesByFarmerId, getSaleHistory, getProductId, isProductPresent, updateProduct, addProduct } from "../models/productModel.js";

import addToCart from "../models/addToCart.js";

import { showFertilizers, showSeeds } from "../models/showProducts.js";

const productRequest = express.Router()

productRequest.get('/getid/:userType/:username', async (req, res) => {
    const userType = req.params.userType
    const username = req.params.username
    const id = await getUserId(userType, username)
    console.log(`id : ${id}`);
    res.json({ farmerId: id })

})

productRequest.get('/stock/:farmerId', async (req, res) => {
    const farmerId = req.params.farmerId
    const typesAvailable = await productTypesByFarmerId(farmerId)
    let availableTypes = []
    availableTypes = await Promise.all(typesAvailable.map(async (type) => {
        let prods = await productsByFarmerId(type.productType, farmerId);
        return { productType: type.productType, products: prods, seeMoreLink: type.seeMoreLink };
    }))

    res.json({ availableTypes: availableTypes })
})

productRequest.get('/salesHistory/:farmerId', async (req, res) => {
    const farmerId = req.params.farmerId
    const sales = await getSaleHistory(farmerId)

    res.json({ sales: sales })
})

productRequest.post('/add-product/:username', async (req, res) => {
    const username = req.params.username
    const productData = req.body
    const id = await getUserId('farmer', username)
    const productId = await getProductId(productData.productName)
    const isPresent = await isProductPresent(productId, id)
    if (isPresent) {
        const response = await fetch(`http://localhost:3000/api/update-product/${username}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(productData)
        })
        return
    }

    await addProduct(id, productId, productData)
})

productRequest.post('/update-product/:username', async (req, res) => {
    const username = req.params.username
    const productData = req.body
    const id = await getUserId('farmer', username)
    const productId = await getProductId(productData.productName)
    const isPresent = await isProductPresent(productId, id)
    if (!isPresent) {
        const response = await fetch(`http://localhost:3000/api/add-product/${username}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(productData)
        })

        return
    }

    await updateProduct(id, productId, productData)

})

productRequest.post('/addToCart', async (req, res) => {
    const { productName, price, quantity, farmerId, consumerId, purchaseDate } = req.body
    addToCart(productName, price, quantity, farmerId, consumerId, purchaseDate)
})

export default productRequest


