
PROJECT_DIR="$(cd $(dirname $0); pwd)"
test -z "$PROJECT_DIR" && exit 1

docker compose -f "$PROJECT_DIR/docker-compose.yml" \
	run --rm -v "$(pwd)":/test francinette "$@"
