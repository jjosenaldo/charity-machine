import { pluck, query } from "../db.js";

// status:
// 0: available
// 1: already consumed
// 2: no items

function getAvailableMeals(userId) {
  // get all the meals the user has retrieved today
  const retrievedMealIds = pluck(
    `SELECT i.meal_id FROM retrievals r
       JOIN items i ON r.item_id = i.id
      WHERE DATE(timestamp) = DATE('now') AND user_id = ?`,
    userId
  );

  const mealQuantities = query(
    `SELECT m.id, SUM(i.quantity) FROM meals m
       JOIN items i ON i.meal_id = m.id
    GROUP BY m.id`
  ).reduce((acc, { id, "SUM(i.quantity)": quantity }) => {
    acc[id] = quantity;
    return acc;
  }, {});

  const availableMeals = query(`SELECT m.* FROM meals m`).map((meal) => {
    let status = 0;

    if (retrievedMealIds.includes(meal.id)) status = 1;
    if (mealQuantities[meal.id] === 0) status = 2;

    return { ...meal, status };
  });

  return availableMeals;
}

export { getAvailableMeals };
