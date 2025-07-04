-- name: CreateTransfer :one
INSERT INTO transfers (
  from_account_id, to_account_id, amount
) VALUES (
    $1, $2, $3
)
RETURNING *;

-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = $1 LIMIT 1;

-- name: ListTransfer :many
SELECT * FROM transfers
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: ListTransferFromAccount :many
SELECT * FROM transfers
ORDER BY from_account_id = $1, to_account_id = $1
LIMIT $2
OFFSET $3;

-- name: ListTransferBetweenAccounts :many
SELECT * FROM transfers
WHERE (from_account_id = $1 AND to_account_id = $2)
   OR (from_account_id = $2 AND to_account_id = $1)
LIMIT $3 OFFSET $4;