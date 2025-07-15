import initSqlConnection from "./database.js";

const con = initSqlConnection(); // Initialize the connection

//common
async function getUserId(userType, username) {
    const col = userType + '_id'
    const table = userType + 's'
    const [rows] = await con.query(`select ${col} as userId from ${table} where user_name=?`, [username])

    console.log(`userid = ${rows[0].userId}`);
    return rows[0].userId


}

async function getUserDetails(userType, username) {
    const [rows] = con.query(`select ${userType}_id as userId`)
}



//consumer
async function getuserDistrict(username) {
    try {
        const [rows] = await con.query(
            `select district as district from consumers
            where user_name = ?`,
            [username]
        );

        console.log(`userDistrict ${rows[0].district}`);
        return rows[0].district
    } catch (error) {
        console.log('error in fetching user district');
    }
}

async function findProductsOfType(productType, userDistrict) {
    try {
        console.log("userDistrict : " + userDistrict);
        const [rows] = await con.query(
            `SELECT distinct p.Product_Name as productName,p.product_type as productType
             FROM Available_Products ap
             JOIN Products p ON ap.Product_ID = p.Product_ID
             JOIN Farmers f ON ap.Farmer_ID = f.Farmer_ID
             WHERE p.Product_Type = ? AND f.district = ?
             group by p.product_name`,
            [productType, userDistrict]
        );
        rows.forEach((product) => {
            product.seeMoreLink = `/product/${product.productType}/${product.productName}`,
                product.image = `/images/${product.productName.toLowerCase()}.jpeg`
        })
        console.log(rows);
        return rows; // Return data
    } catch (error) {
        console.error("Error fetching products by type:", error);
    }
}

// Function to get products by name from farmers in the same district
async function findProductsByName(productName, userDistrict) {
    try {
        console.log("userDistrict : " + userDistrict);
        const [rows] = await con.query(
            `SELECT p.Product_Name as productName, p.Product_Type as productType, ap.Price as price, ap.Farmer_ID as farmerId
             FROM Available_Products ap
             JOIN Products p ON ap.Product_ID = p.Product_ID
             JOIN Farmers f ON ap.Farmer_ID = f.Farmer_ID
             WHERE p.Product_Name = ? AND f.district = ?`,
            [productName, userDistrict]

        );
        rows.forEach((product) => {
            product.seeMoreLink = `/product/${product.productType}/${product.productName}`,
                product.image = `/images/${product.productName.toLowerCase()}.jpeg`
        })
        console.log(rows);
        return rows; // Return data
    } catch (error) {
        console.error("Error fetching products by name:", error);
    }
}

async function findAvailableTypes(userDistrict) {
    try {
        console.log("userDistrict : " + userDistrict);
        const [rows] = await con.query(
            `SELECT distinct p.Product_Type as productType
             FROM Available_Products ap
             JOIN Products p ON ap.Product_ID = p.Product_ID
             JOIN Farmers f ON ap.Farmer_ID = f.Farmer_ID
             WHERE f.district = ?`,
            [userDistrict]

        );
        rows.forEach((type) => {
            type.seeMoreLink = `/product/${type.productType}`
        })
        console.log(rows);
        return rows; // Return data
    } catch (error) {
        console.error("Error fetching products types available:", error);
    }
}


//farmer functions
async function productTypesByFarmerId(id) {
    const [rows] = await con.query(`SELECT distinct p.Product_Type as productType,ap.Farmer_ID as farmerId
             FROM Available_Products ap
             JOIN Products p ON ap.Product_ID = p.Product_ID
             where ap.Farmer_id =?`, [id])

    rows.forEach((type) => {
        type.seeMoreLink = `/product/farmer/${type.productType}`
    })
    return rows
}

async function productsByFarmerId(productType, farmerId) {
    const [rows] = await con.query(`SELECT p.Product_Name as productName,p.product_type as productType ,ap.Price as price, ap.Farmer_ID as farmerId, ap.quantity as quantity
             FROM Available_Products ap
             JOIN Products p ON ap.Product_ID = p.Product_ID
             JOIN Farmers f ON ap.Farmer_ID = f.Farmer_ID
             WHERE p.Product_Type = ? AND f.farmer_id = ?`,
        [productType, farmerId]
    );
    rows.forEach((product) => {
        product.image = `/images/${product.productName.toLowerCase()}.jpeg`
    })

    return rows
}

async function getSaleHistory(farmerId) {
    const [rows] = await con.query(`
        select product_name as productName, price as price, purchase_date as date,quantity_sold as quantity from sold_products where farmer_id =?`, [farmerId])

    rows.forEach((sale) => {
        let date = new Date(sale.date)
        sale.date = date.toLocaleDateString("en-GB");
    })
    return rows
}

async function getProductId(productName) {
    const [rows] = await con.query(`select product_id as productId from products where product_name =?`, [productName])

    return rows[0].productId
}

async function isProductPresent(productId, farmerId) {
    const [rows] = await con.execute(`SELECT * FROM available_products WHERE product_Id = ? AND farmer_Id = ?`,
        [productId, farmerId]
    );

    if (rows.length === 0) {
        return false
    }
    else {
        return true
    }
}

async function addProduct(farmerId, productId, productData) {
    try {
        await con.query(
            `INSERT INTO available_products (farmer_id,product_id,product_name,quantity,price) VALUES (?, ?,?,?,?)`,
            [farmerId, productId, productData.productName, productData.quantity, productData.price]
        );

        console.log("Product added successfully!");

    } catch (error) {
        console.error("Error adding product:", error);

    }
}

async function updateProduct(farmerId, productId, productData) {
    try {
        await con.query(
            `update available_products set quantity = quantity + ? , price =? where farmer_id = ? and product_id =? `,
            [productData.quantity, productData.price, farmerId, productId]
        );
        console.log("Product added successfully!");

    } catch (error) {
        console.error("Error adding product:", error);

    }
}


export { findProductsByName, findProductsOfType, findAvailableTypes, getuserDistrict, getUserId, productTypesByFarmerId, productsByFarmerId, getSaleHistory, getProductId, isProductPresent, updateProduct, addProduct }