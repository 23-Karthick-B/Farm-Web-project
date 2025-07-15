import express from "express"
import initSqlConnection from "./database.js"

const con = initSqlConnection()

const showFertilizers = async () => {
  const [fertilizers] = await con.query('select fertilizer_id as id,supplier_id as supplierId,fertilizer_name as name,availability as availability,unit_price as price from fertilizers')
  return fertilizers

}

const showSeeds = async () => {
  const [seeds] = await con.query('select seed_id as id,supplier_id as supplierId,seed_name as name,availability as availability,price as price from seeds')
  return seeds


}

export { showFertilizers, showSeeds }