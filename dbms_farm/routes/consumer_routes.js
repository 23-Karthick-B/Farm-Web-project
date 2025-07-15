import { name } from "ejs";
import express from "express";
import { findAvailableTypes, findProductsByName, findProductsOfType, getuserDistrict } from "../models/productModel.js";

const consumerRouter = express.Router()


consumerRouter.get('/:username', async (req, res) => {
    const username = req.params.username
    const userDistrict = await getuserDistrict(username)
    const typesAvailable = await findAvailableTypes(userDistrict)
    let availableProducts = []
    availableProducts = await Promise.all(typesAvailable.map(async (type) => {
        let prods = await findProductsOfType(type.productType, userDistrict);
        return { productType: type.productType, products: prods, seeMoreLink: type.seeMoreLink };
    }))

    console.log("available", availableProducts);
    res.render('consumer.ejs', {
        username: username,
        productTypes: availableProducts,
        orders: [
            { productName: "Wheat", price: 200, quantity: 3 },
            { productName: "Rice", price: 150, quantity: 5 },
        ]
    })
})

export default consumerRouter