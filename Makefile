# Docker Registry Management
# ========================

.PHONY: help registry-start registry-stop registry-restart registry-logs registry-status registry-clean registry-test

# Default target
help:
	@echo "Docker Registry Management"
	@echo "========================"
	@echo ""
	@echo "Available targets:"
	@echo "  registry-start    - Start the local Docker registry"
	@echo "  registry-stop     - Stop the local Docker registry"
	@echo "  registry-restart  - Restart the local Docker registry"
	@echo "  registry-logs     - Show registry logs"
	@echo "  registry-status   - Show registry status"
	@echo "  registry-clean    - Stop and remove all data (WARNING: deletes all images)"
	@echo "  registry-test     - Test if registry is running"
	@echo "  help             - Show this help message"

# Start the registry
registry-start:
	@echo "Starting local Docker registry on port 32000..."
	docker-compose up -d
	@echo "Registry started! Access at localhost:32000"

# Stop the registry
registry-stop:
	@echo "Stopping local Docker registry..."
	docker-compose down
	@echo "Registry stopped"

# Restart the registry
registry-restart: registry-stop registry-start

# Show registry logs
registry-logs:
	@echo "Registry logs:"
	docker-compose logs -f registry

# Show registry status
registry-status:
	@echo "Registry status:"
	docker-compose ps
	@echo ""
	@echo "Registry info:"
	@curl -s http://localhost:32000/v2/_catalog 2>/dev/null || echo "Registry not responding"

# Clean up registry (removes all data)
registry-clean:
	@echo "WARNING: This will delete all images in the registry!"
	@read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	@echo "Stopping and removing registry data..."
	docker-compose down -v
	@echo "Registry data cleaned up"

# Test if registry is running
registry-test:
	@echo "Testing registry connection..."
	@curl -s http://localhost:32000/v2/_catalog >/dev/null && echo "✅ Registry is running" || echo "❌ Registry is not responding" 