from flask import Flask, request
app = Flask(__name__)
ListOfMessages = []


@app.route('/')
def hello_world():
    return 'Messanger Flask is running' \
           '<br> <a href="/status">Check status</a>'


@app.route('/status')
def status():
    return{
        'messages count': len(ListOfMessages)
    }


@app.route('/api/Messanger', methods=['POST'])
def SendMessage():
    msg = request.json
    print(msg)
    ListOfMessages.append(msg)
    msgtext = f"{msg['UserName']} <{msg['TimeStamp']}>: {msg['MessageText']} "
    print(f"Всего сообщений: {len(ListOfMessages)} Отправленное сообщение: {msgtext}")
    return f"Сообщение отправлено успешно. Всего сообщений: {len(ListOfMessages)}", 200


@app.route('/api/Messanger/<int:id>')
def GetMessage(id):
    print(id)
    if id < 0 or id >= len(ListOfMessages):
        return "Not Found", 400
    print(ListOfMessages[id])
    return ListOfMessages[id],200


if __name__ == '__main__':
    app.run()
