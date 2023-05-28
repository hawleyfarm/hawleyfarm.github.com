import type { TinaField } from "tinacms";
export function blog_templateFields() {
  return [
    {
      type: "string",
      name: "title",
      label: "Title",
    },
    {
      type: "datetime",
      name: "date",
      label: "Date",
    },
    {
      type: "string",
      name: "tags",
      label: "Tags",
      list: true,
      ui: {
        component: "tags",
      },
    },
    {
      type: "object",
      name: "gallery",
      label: "Gallery",
      list: true,
      fields: [
        {
          type: "image",
          name: "thumb",
          label: "Thumb",
        },
        {
          type: "image",
          name: "image",
          label: "Image",
        },
        {
          type: "string",
          name: "title",
          label: "Title",
        },
      ],
    },
  ] as TinaField[];
}
