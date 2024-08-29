#!/bin/bash

# Variables
ACCOUNT_ID="${ACCOUNT_ID}"
BUDGET_NAME="GudisaBudgetsNew"

# Paths to your JSON files
BUDGET_FILE="./budget.json"
NOTIFICATION_FILE="./budget-notification.json"

# Check if the JSON files exist
if [[ ! -f "$BUDGET_FILE" ]]; then
    echo "Budget JSON file ($BUDGET_FILE) not found!"
    exit 1
fi

if [[ ! -f "$NOTIFICATION_FILE" ]]; then
    echo "Notification JSON file ($NOTIFICATION_FILE) not found!"
    exit 1
fi

# Check if the ACCOUNT_ID is set
if [[ -z "$ACCOUNT_ID" ]]; then
    echo "AWS account ID is not set in the environment variable ACCOUNT_ID."
    exit 1
fi

# Create the budget
echo "Creating budget..."
aws budgets create-budget --account-id "$ACCOUNT_ID" --budget file://"$BUDGET_FILE"

if [ $? -eq 0 ]; then
    echo "Budget created successfully."
else
    echo "Failed to create budget."
    exit 1
fi

# Read notification JSON content
NOTIFICATION_JSON=$(cat "$NOTIFICATION_FILE")

# Create the notification
aws budgets create-notification \
    --account-id "$ACCOUNT_ID" \
    --budget-name "GudisaBudgetsNew" \
    --notification '{"NotificationType": "ACTUAL", "ComparisonOperator": "GREATER_THAN", "Threshold": 50, "ThresholdType": "PERCENTAGE"}' \
    --subscribers '[{"Address": "example@gmail.com", "SubscriptionType": "EMAIL"}]'

if [ $? -eq 0 ]; then
    echo "Notification created successfully."
else
    echo "Failed to create notification."
    exit 1
fi
