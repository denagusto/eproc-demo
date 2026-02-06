#!/bin/bash
# Database Restore Script for eProcurement Demo
# Author: Claude Code
# Date: 2026-02-06

set -e

echo "🗄️  eProcurement Database Restore Script"
echo "========================================"
echo ""

# Configuration
CONTAINER_NAME="eproc-postgres"
DB_NAME="eproc_demo"
DB_USER="eproc"
BACKUP_FILE="backup-20260206-160056.sql"

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: Backup file '$BACKUP_FILE' not found!"
    exit 1
fi

echo "📋 Configuration:"
echo "   Container: $CONTAINER_NAME"
echo "   Database: $DB_NAME"
echo "   User: $DB_USER"
echo "   Backup: $BACKUP_FILE"
echo ""

# Check if container is running
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo "❌ Error: Container '$CONTAINER_NAME' is not running!"
    echo "   Run: docker-compose up -d postgres"
    exit 1
fi

echo "🔄 Waiting for PostgreSQL to be ready..."
until docker exec $CONTAINER_NAME pg_isready -U $DB_USER > /dev/null 2>&1; do
    echo "   Waiting..."
    sleep 2
done
echo "✅ PostgreSQL is ready!"
echo ""

echo "🧹 Dropping existing database (if exists)..."
docker exec -i $CONTAINER_NAME psql -U $DB_USER -c "DROP DATABASE IF EXISTS $DB_NAME;" postgres 2>/dev/null || true

echo "📦 Creating fresh database..."
docker exec -i $CONTAINER_NAME psql -U $DB_USER -c "CREATE DATABASE $DB_NAME;" postgres

echo "📥 Restoring database from backup..."
echo "   This may take a few minutes..."
docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME < "$BACKUP_FILE"

echo ""
echo "✅ Database restore completed successfully!"
echo ""
echo "📊 Database Statistics:"
docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -c "\dt" 2>/dev/null | grep -E "List of relations|public|rows" || true
echo ""
echo "🎉 Done! Database is ready for use."
