import {
  Refine,
  GitHubBanner,
  WelcomePage,
  Authenticated,
  AuthPage,
  ErrorComponent,
} from "@refinedev/core";
import { DevtoolsPanel, DevtoolsProvider } from "@refinedev/devtools";

import { NotificationsProvider } from "@mantine/notifications";

import { BrowserRouter, Route, Routes, Outlet } from "react-router-dom";
import routerBindings, {
  NavigateToResource,
  CatchAllNavigate,
  UnsavedChangesNotifier,
  DocumentTitleHandler,
} from "@refinedev/react-router-v6";
import { dataProvider, liveProvider } from "@refinedev/supabase";
// import { Layout } from "./components/layout";
import "./App.css";
import { supabaseClient } from "./utility";
import authProvider from "./authProvider";

import { ThemedLayoutV2, notificationProvider } from "@refinedev/mantine";
import { MantineProvider } from "@mantine/core";
import { genCountriesResources, genCountriesRoutes } from "./routes/countries";
import { genSportmansResources, genSportmansRoutes } from "./routes/sportmans";
import { genMembersResources, genMembersRoutes } from "./routes/members";
import { genTeamsResources, genTeamsRoutes } from "./routes/teams";
import { LoginPage, RegisterPage } from "./pages/auth/components";

function App() {
  return (
    <BrowserRouter>
      <GitHubBanner />
      <MantineProvider>
        <DevtoolsProvider>
          <NotificationsProvider position="top-right">
            <Refine
              authProvider={authProvider}
              dataProvider={dataProvider(supabaseClient)}
              liveProvider={liveProvider(supabaseClient)}
              notificationProvider={notificationProvider}
              options={{
                syncWithLocation: true,
                warnWhenUnsavedChanges: true,
                projectId: "Ms2TKE-HJmtfS-fOX22k",
              }}
              routerProvider={routerBindings}
              resources={[
                ...genCountriesResources(),
                ...genMembersResources(),
                ...genSportmansResources(),
                ...genTeamsResources(),
              ]}>
                <ThemedLayoutV2>
                  <Routes>

                    <Route index element={<WelcomePage />} />

                    <Route path="/login" element={<LoginPage />} />
                    <Route path="/register" element={<RegisterPage />} />

                    <Route
                      element={
                        <Authenticated fallback={<CatchAllNavigate to="/login" />}>
                          <Outlet />
                        </Authenticated>
                      }
                    >
                      {genCountriesRoutes()}
                      {genMembersRoutes()}
                      {genSportmansRoutes()}
                      {genTeamsRoutes()}
                    </Route>
                  </Routes>
                  <UnsavedChangesNotifier />
                  <DocumentTitleHandler />
                </ThemedLayoutV2>
            </Refine>
          </NotificationsProvider>
          <DevtoolsPanel />
        </DevtoolsProvider>
      </MantineProvider>
    </BrowserRouter>
  );
}

export default App;
