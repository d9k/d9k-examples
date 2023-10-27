import {
    InferField,
} from "@refinedev/inferencer/mantine";

export const fieldTransformer = (field: InferField) => {
    console.log('fieldTransformer', field);

    if (field.key == 'sportman_id') {
        field.resource = {
            "name": "sportmans",
            "list": "/sportmans",
            "create": "/sportmans/create",
            "edit": "/sportmans/edit/:id",
            "show": "/sportmans/show/:id",
            "route": "/sportmans",
            "canCreate": true,
            "canEdit": true,
            "canShow": true
        };
    }

    // if (["locale", "updatedAt", "publishedAt"].includes(field.key)) {
    //     return false;
    // }

    return field;
};