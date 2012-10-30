module DestroyableExtension
  def destroyable?(assoc_exceptions = [])
    association_names = []
    self.class.reflections.each { |key, value| association_names << key if value.instance_of?(ActiveRecord::Reflection::AssociationReflection) }
    association_names.each do |assoc|
      if !assoc_exceptions.include?(assoc) #esto sirve para excluir una assoc por algun tipo de razon rara (ver el destroy de task_controller)
        if assoc && self.class.reflect_on_association(assoc).macro == :has_many
          options = self.class.reflect_on_association(assoc).options
          if options.has_key?(:dependent)
            #primero veo si es nullify, porque si es entonces debo dejar borrar este registro ya que los asociados a él quedaran con la foreign key en NULL, lo que esta bien porque por eso le puse nullify
            return true if options[:dependent] == :nullify

            #hay que checar si cada uno de los child se pueden borrar, si tan solo uno no se puede entonces self no puede borrarse
            #este comporatamiento se hara en cadena, es decir, si child tiene :has_many xx entonces se preguntara si se pueden borrar los xx
            eval("self." + assoc.to_s).each do |child|
              if !child.destroyable?
                errors.add_to_base I18n.t("screens.errors.cant_delete_this_record_2", :association => I18n.t("activerecord.models." + assoc.to_s.camelize))
                return false
              end
            end
          elsif eval("self." + assoc.to_s + ".count") > 0
            errors.add_to_base I18n.t("screens.errors.cant_delete_this_record", :association => I18n.t("activerecord.models." + assoc.to_s.camelize))
            return false
          end
        end
      end
    end
    return true
  end

end

ActiveRecord::Base.send(:include, DestroyableExtension)