import { Redirect } from 'expo-router';

export default function Index() {
  // Temporary redirect to auth.
  // In a real app, you would check the session here.
  return <Redirect href="/(auth)" />;
}
