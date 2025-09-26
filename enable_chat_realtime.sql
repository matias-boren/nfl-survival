-- Enable real-time for chat_messages table
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;

-- Grant necessary permissions for real-time
GRANT SELECT ON chat_messages TO authenticated;
GRANT SELECT ON chat_messages TO anon;
