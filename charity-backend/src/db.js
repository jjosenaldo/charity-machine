import sqlite from "better-sqlite3";
import { resolve } from "path";

const db = new sqlite(resolve("charity-machine.db"), { fileMustExist: true });

function query(sql, ...params) {
  return db.prepare(sql).all(params);
}

function pluck(sql, ...params) {
  return db.prepare(sql).pluck(true).all(params);
}

function get(sql, ...params) {
  return db.prepare(sql).get(params);
}

function run(sql, ...params) {
  return db.prepare(sql).run(params);
}

export { query, pluck, get, run };
