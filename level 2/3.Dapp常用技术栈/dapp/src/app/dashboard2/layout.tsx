import { Suspense } from "react";

export default function RootLayout({
  children,
  analytics,
  team,
}: Readonly<{
  children: React.ReactNode;
  analytics: React.ReactNode;
  team: React.ReactNode;
}>) {
  return (
    <>
      {analytics}
      {children}
      {team}
    </>
  );
}
