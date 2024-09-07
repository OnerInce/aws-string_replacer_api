def handler(event, context):
    try:
        input_text = event["queryStringParameters"]["input"]
    except KeyError:
        return {
            'statusCode': 404,
            'body': {'Exception': 'Please provide a query paramater named input'}
        }

    replaced_text = input_text.replace("Google", "Google©").replace("Fugro", "Fugro B.V.").replace("Holland", "The Netherlands")
    
    return {"original_text": input_text, "replaced_text": replaced_text}
