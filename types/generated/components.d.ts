import type { Schema, Struct } from '@strapi/strapi';

export interface AboutMeRecommendation extends Struct.ComponentSchema {
  collectionName: 'components_about_me_recommendations';
  info: {
    description: '';
    displayName: 'Recommendation';
    icon: 'comment-medical';
  };
  attributes: {
    author: Schema.Attribute.String;
    company_job: Schema.Attribute.String;
    company_logo: Schema.Attribute.Media<'images'>;
    company_logo_is_colored: Schema.Attribute.Boolean &
      Schema.Attribute.DefaultTo<true>;
    company_name: Schema.Attribute.String;
    company_title: Schema.Attribute.RichText;
    message: Schema.Attribute.String;
    picture: Schema.Attribute.Media<'images'>;
  };
}

export interface HeroWriter extends Struct.ComponentSchema {
  collectionName: 'components_hero_writers';
  info: {
    displayName: 'Writer';
    icon: 'terminal';
  };
  attributes: {
    title: Schema.Attribute.String;
  };
}

export interface IdentitySoftSkills extends Struct.ComponentSchema {
  collectionName: 'components_identity_soft_skills';
  info: {
    description: '';
    displayName: 'Soft Skills';
    icon: 'brain';
  };
  attributes: {
    quality: Schema.Attribute.String;
  };
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'about-me.recommendation': AboutMeRecommendation;
      'hero.writer': HeroWriter;
      'identity.soft-skills': IdentitySoftSkills;
    }
  }
}
