import {
  Refine,
  GitHubBanner,
  WelcomePage,
  Authenticated,
  AuthPage,
  ErrorComponent,
} from "@refinedev/core";
import { DevtoolsPanel, DevtoolsProvider } from "@refinedev/devtools";

import { BrowserRouter, Route, Routes, Outlet } from "react-router-dom";
import routerBindings, {
  NavigateToResource,
  CatchAllNavigate,
  UnsavedChangesNotifier,
  DocumentTitleHandler,
} from "@refinedev/react-router-v6";
import { dataProvider, liveProvider } from "@refinedev/supabase";
import { Layout } from "./components/layout";
import "./App.css";
import { supabaseClient } from "./utility";
import authProvider from "./authProvider";

import { MembersCreate, MembersEdit, MembersList, MembersShow } from "./pages/members";
import { ThemedLayoutV2 } from "@refinedev/mantine";
import { MantineProvider } from "@mantine/core";
import { genCountriesResources, genCountriesRoutes } from "./routes/countries";
import { genSportmansResources, genSportmansRoutes } from "./routes/sportmans";
import { genMembersResources, genMembersRoutes } from "./routes/members";
import { genTeamsResources, genTeamsRoutes } from "./routes/teams";

function App() {
  return (
    <BrowserRouter>
      <GitHubBanner />
      <MantineProvider>
        <DevtoolsProvider>
          <Refine
            dataProvider={dataProvider(supabaseClient)}
            liveProvider={liveProvider(supabaseClient)}
            authProvider={authProvider}
            routerProvider={routerBindings}
            options={{
              syncWithLocation: true,
              warnWhenUnsavedChanges: true,
              projectId: "Ms2TKE-HJmtfS-fOX22k",
            }}
            resources={[
              ...genCountriesResources(),
              ...genMembersResources(),
              ...genSportmansResources(),
              ...genTeamsResources(),
            ]}>
              <ThemedLayoutV2>
                <Routes>
                  <Route index element={<WelcomePage />} />

                  {genCountriesRoutes()}
                  {genMembersRoutes()}
                  {genSportmansRoutes()}
                  {genTeamsRoutes()}
                </Routes>
                <UnsavedChangesNotifier />
                <DocumentTitleHandler />
              </ThemedLayoutV2>
          </Refine>
          <DevtoolsPanel />
        </DevtoolsProvider>
      </MantineProvider>
    </BrowserRouter>
  );
}

export default App;