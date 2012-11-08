class AddFieldsToQuotations < ActiveRecord::Migration
  def self.up
    add_column :quotations, :customer_id, :integer
    add_column :quotations, :press_type_id, :integer
    add_column :quotations, :product_id, :integer
    add_column :quotations, :pages, :integer
    add_column :quotations, :lining, :integer
    add_column :quotations, :volume_1, :integer
    add_column :quotations, :volume_2, :integer
    add_column :quotations, :volume_3, :integer
    add_column :quotations, :volume_4, :integer
    add_column :quotations, :volume_5, :integer

    add_column :quotations, :quotation_volume_1, :integer
    add_column :quotations, :quotation_volume_2, :integer
    add_column :quotations, :quotation_volume_3, :integer
    add_column :quotations, :quotation_volume_4, :integer
    add_column :quotations, :quotation_volume_5, :integer

  end

  def self.down
    remove_column :quotations, :customer_id
    remove_column :quotations, :customer_id
    remove_column :quotations, :press_type_id
    remove_column :quotations, :product_id
    remove_column :quotations, :pages
    remove_column :quotations, :lining
    remove_column :quotations, :volume_1
    remove_column :quotations, :volume_2
    remove_column :quotations, :volume_3
    remove_column :quotations, :volume_4
    remove_column :quotations, :volume_5
    remove_column :quotations, :quotation_volume_1
    remove_column :quotations, :quotation_volume_2
    remove_column :quotations, :quotation_volume_3
    remove_column :quotations, :quotation_volume_4
    remove_column :quotations, :quotation_volume_5
  end
end