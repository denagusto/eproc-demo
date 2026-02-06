-- Fix Approval Workflows - Disable role-based workflows
-- Date: 2026-02-06
-- Reason: Role-based approval not implemented yet, only user-based approval works

BEGIN;

-- Disable all workflows except Admin Test Workflow
UPDATE approval_workflows
SET is_active = false, is_default = false
WHERE entity_type = 'purchase_request'
  AND name != 'Admin Test Workflow';

-- Make Admin Test Workflow the only active and default workflow
UPDATE approval_workflows
SET is_active = true, is_default = true
WHERE name = 'Admin Test Workflow';

-- Verify the fix
SELECT
    id,
    name,
    entity_type,
    is_active,
    is_default,
    created_at
FROM approval_workflows
WHERE entity_type = 'purchase_request'
ORDER BY is_active DESC, created_at DESC;

COMMIT;
