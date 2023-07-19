import { query, get, run } from "../db.js";

function groupBy(objects, property) {
  return objects.reduce((acc, obj) => {
    const key = obj[property];

    if (!acc[key]) acc[key] = [];

    acc[key].push(obj);

    return acc;
  }, {});
}

function getAvailableItems(userId, mealIds) {
  // get all items for the specified mealIds
  const items = query(
    `SELECT * FROM items
      WHERE meal_id IN (${mealIds.map(() => "?").join(", ")}) AND
            quantity > 0`,
    ...mealIds
  );

  // get all item restrictions and group them by the item_id
  const itemsRestrictions = query(
    `SELECT ir.item_id, r.name FROM item_restrictions ir
       JOIN restrictions r ON ir.restriction_id = r.id`
  );
  const restrictionsPerItem = groupBy(itemsRestrictions, "item_id");

  // modify each item with its restrictions and return it
  return items.map((item) => {
    const itemRestrictions = restrictionsPerItem[item.id];

    if (itemRestrictions)
      return {
        ...item,
        restrictions: itemRestrictions.map(({ name }) => name),
      };

    return item;
  });
}

function getItem(itemId) {
  return get(`SELECT * FROM items WHERE id = ?`, itemId);
}

function decreaseItemQuantity(userId, itemId) {
  run(
    `INSERT INTO retrievals (user_id, item_id, timestamp)
     VALUES (?, ?, DATE('now'))`,
    userId,
    itemId
  );

  return run(`UPDATE items SET quantity = quantity - 1 WHERE id = ?`, itemId);
}

export { getAvailableItems, getItem, decreaseItemQuantity };
