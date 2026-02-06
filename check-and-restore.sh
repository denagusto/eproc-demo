#!/bin/bash
# Auto-restore database if empty
# This script runs in a temporary container after postgres is ready

set -e

echo "🔍 Checking if database needs restoration..."

# Wait a bit for postgres to fully start
sleep 2

# Count tables in the database
TABLE_COUNT=$(psql -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';")

if [ "$TABLE_COUNT" -eq "0" ]; then
    echo "📦 Database is empty. Starting restore..."
    echo "📥 Restoring from backup (this may take 2-3 minutes)..."

    psql < /backup.sql

    echo "✅ Database restore completed successfully!"
    echo "📊 Tables created: $(psql -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';")"

    echo "🔧 Applying post-restore fixes..."
    if [ -f /fix-approval-workflows.sql ]; then
        psql < /fix-approval-workflows.sql
        echo "✅ Approval workflows fixed"
    fi
else
    echo "✅ Database already has $TABLE_COUNT tables. Skipping restore."
fi

echo "🎉 Database initialization complete!"
