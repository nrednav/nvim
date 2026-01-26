.PHONY: all setup hooks permissions install benchmark

all: setup benchmark

setup: permissions hooks install
	@echo "✅ Setup complete. Neovim is ready."

hooks:
	@echo "ℹ️ Configuring Git Hooks..."
	@git config core.hooksPath .githooks

permissions:
	@echo "ℹ️ Setting permissions..."
	@chmod +x scripts/*.sh
	@chmod +x .githooks/pre-commit

install:
	@echo "ℹ️ Installing plugins (headless)..."
	@nvim --headless "+Lazy! sync" +qa

benchmark:
	@echo "ℹ️ Running benchmark..."
	@./scripts/benchmark.sh
