# Advanced Chat App

A console-based chat application built with Dart, allowing multiple clients to connect to a server, send messages, and view real-time chat history. Messages are persistently stored in a JSON file (`chat_history.json`) for durability. The app uses TCP sockets for communication and formats timestamps with the `intl` package.

## Features
- **Multi-client Support**: Multiple users can connect to the server and chat simultaneously.
- **Username-based Messaging**: Each client sets a unique username, and messages are displayed as `[yyyy-MM-dd HH:mm:ss] username: message`.
- **Persistent Chat History**: Messages are saved to `chat_history.json` and retained across sessions.
- **Real-time Updates**: Messages are broadcast to all connected clients instantly.
- **Error Handling**: Gracefully handles client disconnections and invalid inputs.
- **Dependencies**:
  - `intl: ^0.19.0` for timestamp formatting.
  - `path: ^1.9.0` for file path handling.

## Project Structure
