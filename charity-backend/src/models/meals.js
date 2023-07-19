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
    `SELECT * FROM meals WHERE id NOT IN (${retrievedMealIds
      .map(() => "?")
      .join(", ")})`,
    ...retrievedMealIds
  );
}

export { getAvailableMeals };
