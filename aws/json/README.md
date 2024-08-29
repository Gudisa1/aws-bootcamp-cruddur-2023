---

# AWS Budget and Notification Setup

This repository contains scripts and instructions for setting up AWS budgets and notifications using the AWS CLI. Follow the steps below to configure and manage your AWS budgets and notifications.

## Prerequisites

- AWS CLI installed and configured. If not, follow the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
- An AWS account with appropriate permissions to create budgets and notifications.
- Environment variable `ACCOUNT_ID` set with your AWS account ID.

## Files

- `budget.json`: JSON file containing the budget configuration.
- `budget-notification.json`: JSON file containing the notification configuration.
- `create_budget_and_notification.sh`: Bash script to create the budget and set up notifications.

## Budget JSON Configuration

`budget.json` example:

```json
{
  "BudgetLimit": {
    "Amount": "5.0",
    "Unit": "USD"
  },
  "BudgetName": "GudisaBudget",
  "BudgetType": "COST",
  "CostFilters": {
    "TagKeyValue": ["user:Key$value1", "user:Key$value2"]
  },
  "CostTypes": {
    "IncludeCredit": false,
    "IncludeDiscount": false,
    "IncludeOtherSubscription": true,
    "IncludeRecurring": true,
    "IncludeRefund": true,
    "IncludeSubscription": true,
    "IncludeSupport": true,
    "IncludeTax": true,
    "IncludeUpfront": true,
    "UseBlended": false
  },
  "TimePeriod": {
    "Start": "2024-08-29T00:00:00Z",
    "End": "2029-08-29T23:59:59Z"
  },
  "TimeUnit": "MONTHLY"
}
```

## Notification JSON Configuration

`budget-notification.json` example:

```json
[
  {
    "Notification": {
      "ComparisonOperator": "GREATER_THAN",
      "NotificationType": "ACTUAL",
      "Threshold": 50,
      "ThresholdType": "PERCENTAGE"
    },
    "Subscribers": [
      {
        "Address": "gudisagebi1@gmail.com",
        "SubscriptionType": "EMAIL"
      }
    ]
  }
]
```

## Bash Script

The `create_budget_and_notification.sh` script performs the following actions:
1. Creates a budget using the configuration in `budget.json`.
2. Sets up a notification for the budget using the configuration in `budget-notification.json`.

### Usage

1. **Set Environment Variable:**

   Ensure you have set the `ACCOUNT_ID` environment variable with your AWS account ID. For example:

   ```bash
   export ACCOUNT_ID="123456789012"
   ```

2. **Run the Script:**

   ```bash
   ./create_budget_and_notification.sh
   ```

   This script will:
   - Create a budget using the provided JSON configuration.
   - Create a notification for the budget using the provided JSON configuration.

## Managing Budgets and Notifications

### In the AWS Console

1. **Sign In to AWS Management Console:**
   - Go to the [AWS Management Console](https://aws.amazon.com/console/).

2. **Navigate to AWS Budgets:**
   - In the search bar at the top of the console, type `Budgets` and select **AWS Budgets** from the dropdown list.

3. **View and Manage Budgets:**
   - Select your budget from the list to view details and notifications.
   - Manage notifications from the **Notifications** section of the budget details page.

### Permissions

Ensure your IAM role or user has the following permissions for managing AWS Budgets:
- `budgets:CreateBudget`
- `budgets:CreateNotification`
- `budgets:DescribeBudgets`
- `budgets:DescribeNotifications`


# AWS Billing Alerts Setup Script

## Overview

This script automates the creation of an SNS topic, a subscription for email notifications, and a CloudWatch alarm to monitor AWS billing. It helps you track your spending and receive notifications when your billing exceeds a specified threshold.

## Script Overview

The script performs the following tasks:
1. **Creates an SNS Topic** for receiving billing notifications.
2. **Subscribes an Email Address** to the SNS Topic for receiving alerts.
3. **Creates a CloudWatch Alarm** that triggers when the billing exceeds a specified threshold.

## Variables

- `ACCOUNT_ID`: Your AWS account ID (should be set as an environment variable).
- `SNS_TOPIC_NAME`: The name of the SNS topic to be created (default: `BillingAlerts`).
- `ALARM_NAME`: The name of the CloudWatch alarm (default: `BillingAlarm`).
- `ALARM_THRESHOLD`: The threshold for the billing alarm in USD (default: `100`).
- `EMAIL_ADDRESS`: The email address to receive notifications.
- `REGION`: The AWS region where the resources will be created (e.g., `us-east-1`).

## Usage

1. **Set Environment Variables:**

   Before running the script, ensure that the `ACCOUNT_ID` environment variable is set. For example:
   ```bash
   export ACCOUNT_ID="123456789012"


## Contributing

If you have any improvements or suggestions, feel free to open an issue or submit a pull request.

---

Feel free to adjust the content according to your needs or additional details you want to include.
