export default ({ env }) => ({
  // CKEditor plugin configuration
  ckeditor: {
    enabled: true,
    config: {
      plugin: {
        // customize disabled plugins
        disablePlugins: [],
        // customize plugins for different fields
        uiColor: '#FAFAFA', // background color of toolbar
        autoGrow: true,
      },
      editor: {
        // toolbar configurations
        toolbar: {
          items: [
            'undo', 'redo',
            '|', 'heading',
            '|', 'bold', 'italic',
            '|', 'link', 'insertTable', 'blockQuote',
            '|', 'bulletedList', 'numberedList', 'outdent', 'indent'
          ]
        },
        language: 'en',
        table: {
          contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells']
        },
        heading: {
          options: [
            { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
            { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
            { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
            { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' }
          ]
        }
      }
    }
  },

  // Upload provider configuration for Cloudinary
  upload: {
    config: {
      provider: 'cloudinary',
      providerOptions: {
        cloud_name: env('CLOUDINARY_NAME'),
        api_key: env('CLOUDINARY_KEY'),
        api_secret: env('CLOUDINARY_SECRET'),
      },
      actionOptions: {
        upload: {},
        uploadStream: {},
        delete: {},
      },
    },
  },

  // Populate deep plugin configuration
  'strapi-v5-plugin-populate-deep': {
    config: {
      defaultDepth: 5,
    }
  },
});
