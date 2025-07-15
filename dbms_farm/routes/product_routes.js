import express, { Router } from "express";
import { findProductsByName, findProductsOfType, findAvailableTypes, getuserDistrict } from "../models/productModel.js";
import { showFertilizers, showSeeds } from "../models/showProducts.js";

const productRouter = express.Router()

productRouter.get('/:userType', async (req, res) => {
    const userType = req.params.userType


})



productRouter.get('/supplier/:productName', async (req, res) => {
    const productName = req.params.productName
    if (productName == "fertilizers") {
        const fertilizersDetails = await showFertilizers();
        console.log(fertilizersDetails)
        res.render('supplier_products.ejs', { type: 'FERTILIZERS', products: fertilizersDetails })

    }
    if (productName == "seeds") {
        const seedsDetails = await showSeeds();
        console.log(seedsDetails)
        res.render('supplier_products.ejs', { type: 'SEEDS', products: seedsDetails })

    }
})

productRouter.get('/:type/:productName', async (req, res) => {

    const productName = req.params.productName
    const username = req.query.username
    const userDistrict = await getuserDistrict(username)
    const products = await findProductsByName(productName, userDistrict)
    res.render('product_details.ejs', {
        productName: productName,
        products: products
    })

})

export default productRouter