export default ({ env }) => ({
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
