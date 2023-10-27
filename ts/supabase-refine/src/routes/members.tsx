import { Route } from "react-router-dom";
import { MembersCreate, MembersEdit, MembersList, MembersShow } from "../pages/members";

export const genMembersRoutes = () => ([
    <Route path="/members" key="members">
        <Route index element={<MembersList />} />
        <Route path="create" element={<MembersCreate />} />
        <Route path="edit/:id" element={<MembersEdit />} />
        <Route path="show/:id" element={<MembersShow />} />
    </Route>
]);

export const genMembersResources = () => ([{
    name: "members",
    list: "/members",
    create: "/members/create",
    edit: "/members/edit/:id",
    show: "/members/show/:id"
}]);