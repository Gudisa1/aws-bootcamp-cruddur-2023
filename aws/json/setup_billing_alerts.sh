#!/bin/bash

# Variables
ACCOUNT_ID="${ACCOUNT_ID}"
SNS_TOPIC_NAME="BillingAlerts"
ALARM_NAME="BillingAlarm"
ALARM_THRESHOLD=2
EMAIL_ADDRESS="gudisagebi1@gmail.com"
REGION="us-east-1"

# Create SNS Topic
echo "Creating SNS topic..."
TOPIC_ARN=$(aws sns create-topic --name "$SNS_TOPIC_NAME" --query 'TopicArn' --output text --region "$REGION")

if [ $? -eq 0 ]; then
    echo "SNS topic created successfully. Topic ARN: $TOPIC_ARN"
else
    echo "Failed to create SNS topic."
    exit 1
fi

# Subscribe to SNS Topic
echo "Creating SNS subscription..."
aws sns subscribe --topic-arn "$TOPIC_ARN" --protocol email --notification-endpoint "$EMAIL_ADDRESS" --region "$REGION"

if [ $? -eq 0 ]; then
    echo "SNS subscription created successfully. Check your email to confirm the subscription."
else
    echo "Failed to create SNS subscription."
    exit 1
fi

# Create CloudWatch Alarm
echo "Creating CloudWatch alarm..."
aws cloudwatch put-metric-alarm \
    --alarm-name "$ALARM_NAME" \
    --alarm-description "Alarm when billing exceeds $ALARM_THRESHOLD" \
    --metric-name EstimatedCharges \
    --namespace AWS/Billing \
    --statistic Sum \
    --period 86400 \
    --threshold "$ALARM_THRESHOLD" \
    --comparison-operator GreaterThanThreshold \
    --evaluation-periods 1 \
    --alarm-actions "$TOPIC_ARN" \
    --region "$REGION"

if [ $? -eq 0 ]; then
    echo "CloudWatch alarm created successfully."
else
    echo "Failed to create CloudWatch alarm."
    exit 1
fi

echo "All tasks completed successfully."
