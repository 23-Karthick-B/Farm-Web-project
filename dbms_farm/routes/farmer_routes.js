import express from "express";
import productRequest from "../controllers/product_requests.js";

const farmerRouter = express.Router()

const baseUrl = 'http://localhost:3000'
farmerRouter.get('/', (req, res) => {
    res.send('hello farmer')
})

farmerRouter.get('/:username', async (req, res) => {
    const username = req.params.username
    const farmerIdRes = await fetch(`${baseUrl}/api/getid/farmer/${username}`, { headers: { "Content-Type": "application/json" } })
    const { farmerId } = await farmerIdRes.json()
    console.log("farmerid", farmerId);
    const availableTypesRes = await fetch(`${baseUrl}/api/stock/${farmerId}`, { headers: { "Content-Type": "application/json" } })

    const { availableTypes } = await availableTypesRes.json()

    console.log("available", availableTypes);

    const salesHistoryRes = await fetch(`${baseUrl}/api/salesHistory/${farmerId}`, { headers: { "Content-Type": "application/json" } })

    const { sales } = await salesHistoryRes.json()
    console.log("sales", sales);
    res.render('farmer.ejs', {
        username: username,
        productTypes: availableTypes,
        salesHistory: sales
    })
})

farmerRouter.post('/:username/update-product', async (req, res) => {
    console.log("body : ", req.body);
    const productData = req.body
    const username = req.params.username
    const response = await fetch(`http://localhost:3000/api/update-product/${username}`, {
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(productData)
    })
    const responseData = await response.json()
    if (responseData.okResponse)
        res.json({ ok: true })
    else
        res.json({ ok: false })
})

farmerRouter.post('/:username/add-product', async (req, res) => {
    console.log("body : ", req.body);
    const productData = req.body
    const username = req.params.username
    const response = await fetch(`http://localhost:3000/api/add-product/${username}`, {
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(productData)
    })
    const responseData = await response.json()
    if (responseData.okResponse)
        res.json({ ok: true })
    else
        res.json({ ok: false })
})
export default farmerRouter