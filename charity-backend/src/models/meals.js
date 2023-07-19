import { pluck, query } from "../db.js";

function getAvailableMeals(userId) {
  // get all the meals the user has retrieved today
  const retrievedMealIds = pluck(
    `SELECT i.meal_id FROM retrievals r
       JOIN items i ON r.item_id = i.id
      WHERE DATE(timestamp) = DATE('now') AND user_id = ?`,
    userId
  );

  return query(
    `SELECT m.* FROM meals m
       JOIN items i ON i.meal_id = m.id
      WHERE id NOT IN (${retrievedMealIds.map(() => "?").join(", ")}) AND
            i.quantity > 0
     GROUP BY m.id`,
    ...retrievedMealIds
  );
}

export { getAvailableMeals };
