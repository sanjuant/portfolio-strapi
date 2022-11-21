const { winston } = require("@strapi/logger");

export default {
  transports: [
    new winston.transports.Console({
      level: "error",
    }),
  ],
};
