PROJECT = charity-machine
BACKEND_DIR = charity-backend

all: reset-db backend

reset-db:
	@echo Resetting the database
	@rm $(BACKEND_DIR)/$(PROJECT).db
	@sqlite3 $(BACKEND_DIR)/$(PROJECT).db < $(BACKEND_DIR)/$(PROJECT).sql

backend:
	@echo Starting the backend
	@cd $(BACKEND_DIR) && npm run start

watch-backend:
	@echo Watching the backend
	@cd $(BACKEND_DIR) && npm run watch
