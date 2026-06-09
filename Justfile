set dotenv-load := true

COMPOSE_FILE := "docker-compose.yml"

# Show available recipes
default:
    @just --list

# Start Isaac Sim container in standby mode (background)
up:
    docker compose -f {{ COMPOSE_FILE }} up -d

# Stop and remove the Isaac Sim container
down:
    docker compose -f {{ COMPOSE_FILE }} down

# Launch Isaac Sim GUI inside the running container (extension available in Extension Manager)
gui:
    docker compose -f {{ COMPOSE_FILE }} exec isaac-sim \
        /isaac-sim/isaac-sim.sh \
        --ext-folder /isaac-sim/exts \
        --enable isaac.sim.mcp_extension

# Set up Python venv (creates .venv via uv)
setup:
    ./scripts/setup_python_env.sh

# Run the MCP server (requires .venv)
mcp:
    ./scripts/run_mcp_server.sh
