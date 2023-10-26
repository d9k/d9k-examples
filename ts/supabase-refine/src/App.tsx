import {
  Refine,
  GitHubBanner,
  WelcomePage,
  Authenticated,
  AuthPage,
  ErrorComponent,
} from "@refinedev/core";
import { DevtoolsPanel, DevtoolsProvider } from "@refinedev/devtools";
import { RefineKbar, RefineKbarProvider } from "@refinedev/kbar";

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
import { CountriesCreate, CountriesEdit, CountriesList, CountriesShow } from "./pages/countries";

function App() {
  return (
    <BrowserRouter>
      <GitHubBanner />
      <RefineKbarProvider>
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
            resources={[{
              name: "countries",
              list: "/countries",
              create: "/countries/create",
              edit: "/countries/edit/:id",
              show: "/countries/show/:id"
            }, {
              name: "countries",
              list: "/countries",
              create: "/countries/create",
              edit: "/countries/edit/:id",
              show: "/countries/show/:id"
            }]}>
            <Routes>
              <Route index element={<WelcomePage />} />
              <Route path="/countries">
                <Route index element={<CountriesList />} />
                <Route path="create" element={<CountriesCreate />} />
                <Route path="edit/:id" element={<CountriesEdit />} />
                <Route path="show/:id" element={<CountriesShow />} />
              </Route>
            </Routes>
            <RefineKbar />
            <UnsavedChangesNotifier />
            <DocumentTitleHandler />
          </Refine>
          <DevtoolsPanel />
        </DevtoolsProvider>
      </RefineKbarProvider>
    </BrowserRouter>
  );
}

export default App;
