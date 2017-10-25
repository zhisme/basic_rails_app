ActiveModel::Name.class_eval do
  # While we use only :en locale, this one mathes `other` plural form.
  # But this is not the case for some other languages.
  # So this should be reviewed, when any other language is added.
  def human_plural
    human(count: 10)
  end
end
